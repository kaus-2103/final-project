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
    collection_name = params[:ticket][:collection] || "N/A"  
    link = params[:ticket][:link]
    current_user_email = current_user.accountId  
    puts "======================================================================"
    puts "accountID: #{current_user_email}"
    put "======================================================================="
    issue_key = client.create_issue(summary, priority, collection_name, link, current_user_email)

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
  end
  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection)
  end
end
