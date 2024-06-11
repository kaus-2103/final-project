require 'jira-ruby'

class TicketsController < ApplicationController
  def new
    @ticket = Ticket.new
    @link = request.referrer.to_s || "No referrer"
  end

  def create
    client = JiraClient.new
    summary = params[:ticket][:summary]
    priority = params[:ticket][:priority]
    link = params[:ticket][:link]
    description = params[:ticket][:description]
    collection_id = extract_collection_id(link)

    collection_name = if collection_id
                        Collection.find_by(id: collection_id)&.name || "N/A"
                      else
                        "N/A"
                      end

    current_user_email = current_user.accountId  
    puts collection_name

    issue_key = client.create_issue(summary, priority, collection_name, link, current_user_email,description)

    if issue_key
      @ticket = Ticket.new(ticket_params.merge(key: issue_key))

      if @ticket.save
        redirect_to root_path, notice: 'Support ticket created successfully'
      else
        render :new, alert: 'Failed to save support ticket'
      end
    else
      redirect_to root_path, alert: 'Failed to create support ticket in Jira'
    end
  end

  def show
    @tickets = Ticket.all
    client = JiraClient.new
    @ticket_statuses = @tickets.each_with_object({}) do |ticket, statuses|
      statuses[ticket.key] = client.get_issue_status(ticket.key)
    end
  end
  
  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection)
  end
  def extract_collection_id(link)
    # Adjusted regex to capture the collection ID regardless of what follows
    match = link.match(/\/collection\/(\d+)(\/|$)/)
    match[1] if match
  end
end
