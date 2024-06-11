require 'httparty'
require 'json'
require 'base64'
require 'dotenv'
class JiraClient
    include HTTParty
    base_uri ENV['JIRA_SITE']
  
    def initialize
      @auth = {
        username: ENV['JIRA_API_USERNAME'],
        password: ENV['JIRA_API_TOKEN']
      }
    end
  
    def search_user(query)
      email = ENV['JIRA_API_USERNAME']
      api_token = ENV['JIRA_API_TOKEN']
      auth = Base64.strict_encode64("#{email}:#{api_token}")
    
      url = "https://final-project-icik.atlassian.net/rest/api/2/user/search?query=#{query}"
      headers = {
        'Authorization' => "Basic #{auth}",
        'Accept' => 'application/json'
      }
    
      response = HTTParty.get(url, headers: headers)
    
      puts "Response: #{response.code} #{response.message}"
      puts response.body
      if response.code == 200
        users = JSON.parse(response.body)
        users.each do |user|
          puts "Display Name: #{user['displayName']}, Account ID: #{user['accountId']}"
    
          # Assuming the query is the email of the user in your system
          local_user = User.find_by(email: query)
          if local_user
            local_user.update(accountId: user['accountId'])
            puts "Account ID saved for user #{local_user.email}"
          else
            puts "User with email #{query} not found in local database."
          end
        end
      else
        puts "Failed to fetch users: #{response.body}"
      end
    end
  
    def create_user(email, display_name, products)
      g_email = ENV['JIRA_API_USERNAME']
      api_token = ENV['JIRA_API_TOKEN']
      auth = Base64.strict_encode64("#{g_email}:#{api_token}")
      puts "email: #{email}"

      url = 'https://final-project-icik.atlassian.net/rest/api/2/user'
      headers = {
        'Authorization' => "Basic #{auth}",
        'Accept' => 'application/json',
        'Content-Type' => 'application/json'
        }
      body = {
        "displayName": display_name,
        "emailAddress": "#{email}",
        "products": products
      }.to_json

      response = HTTParty.post(url, headers: headers, body: body)

      puts "Response: #{response.code} #{response.message}"
      puts response.body
    end

    def create_issue(summary, priority, collection_name, link, accountID)
      puts "accountID: #{accountID}"
        body_data = {
          "fields" => {
            "summary" => "Help Needed: #{summary}",
            "issuetype" => { "id" => "10003" },
            "reporter" => { "id" => accountID },
            "priority" => { "id" => priority },
            "customfield_10063" => link,  # Directly passing the link as a string
            "project" => { "key" => "FPI" },
            "description" => "Reported by: #{current_user_email}\nCollection: #{collection_name}",
          }
        }.to_json
      
        response = HTTParty.post(
          "https://final-project-icik.atlassian.net/rest/api/2/issue",
          body: body_data,
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Basic #{Base64.strict_encode64("#{ENV['JIRA_API_USERNAME']}:#{ENV['JIRA_API_TOKEN']}")}"
          }
        )
      
        puts "Response: #{response.code} #{response.message}"
        puts response.body
        if response.code == 201
            issue_key = JSON.parse(response.body)['key']
            return issue_key
          else
            puts "Failed to create issue: #{response.body}"
            return nil
          end
      end
            
  end
  