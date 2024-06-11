require 'jira-ruby'
class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
  end

  def create
    client = JiraClient.new
    summary = params[:summary]
    priority = params[:priority]
    collection_name = params[:collection] || "N/A"  # Assuming collection might be optional
    link = request.referer
    current_user_email = current_user.email  # Assuming Devise for user authentication
  
    client.create_issue(summary, priority, collection_name, link, current_user_email)
  end
  

  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection)
  end

  # def create_jira_ticket(ticket)
  #   issue = client.Issue.build
  #   issue.save({
  #     'fields' => {
  #       'summary'     => ticket.summary,
  #       'description' => "Reported by: #{ticket.reported}\nCollection: #{ticket.collection}\nLink: #{ticket.link}",
  #       'project'     => { 'key' => 'YOUR_PROJECT_KEY' },
  #       'issuetype'   => { 'name' => 'Task' },
  #       'priority'    => { 'name' => ticket.priority },
  #       'assignee'    => { 'name' => ticket.reported },
  #       'status'      => { 'name' => 'Open' }
  #     }
  #   })
  # end
end
