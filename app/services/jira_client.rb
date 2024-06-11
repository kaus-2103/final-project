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

    def create_issue(summary, priority, collection_name, link, current_user_email)
        email = ENV['JIRA_API_USERNAME']
        api_token = ENV['JIRA_API_TOKEN']
        auth = Base64.strict_encode64("#{email}:#{api_token}")
        
        url = 'https://final-project-icik.atlassian.net/rest/api/2/issue'
        headers = {
          'Authorization' => "Basic #{auth}",
          'Accept' => 'application/json',
          'Content-Type' => 'application/json'
        }
      
        body_data = {
          "fields" => {
            "summary" => "Help Needed: #{summary}",
            "issuetype" => { "id" => "10003" },
            "reporter" => { "id" => "557058:68ab4dcb-7a30-4b40-81bf-7adc536192c7" },
            "project" => { "key" => "FPI" },  
            "description" => "Reported by: #{current_user_email}\nCollection: #{collection_name}\nLink: #{link}",
            "assignee" => { "emailAddress" => "#{current_user_email}"  }
          }
        }.to_json
      
        response = HTTParty.post(url, headers: headers, body: body_data)
      
        puts "Response: #{response.code} #{response.message}"
        puts response.body
      end      
  end
  