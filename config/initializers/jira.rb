require 'jira-ruby'


# Get the API token from environment variables
api_token = ENV['JIRA_API_TOKEN']

@options = {
  :site               => 'https://final-project-icik.atlassian.net',
  :context_path       => '',
  :username           => 'kaushikroy2103@gmail.com',
  :password           => api_token,
  :auth_type          => :basic
}

client = JIRA::Client.new(@options)

project = client.Project.find('FPI')

project.issues.each do |issue|
  puts "#{issue.id} - #{issue.summary}"
end
