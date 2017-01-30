# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text(65535)
#  status     :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tickets_on_status   (status)
#  index_tickets_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Ticket, :type => :model do

  it "requires title" do
    ticket = Ticket.create title: nil
    expect(ticket.errors.messages[:title]).to include('can\'t be blank')
  end

  it "requires content" do
    ticket = Ticket.create content: nil
    expect(ticket.errors.messages[:content]).to include('can\'t be blank')
  end

  it "has default status" do
    ticket = create :ticket
    expect(ticket.open?).to be(true)
  end

  it "requires a user" do
    ticket = Ticket.create user_id: nil
    expect(ticket.errors.messages[:user_id]).to include('can\'t be blank')
  end
end
