require 'pry'
require_relative 'contact'
class CRM
@@current_contact = []
  def initialize; end

  def main_menu
    loop do # repeat indefinitely
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
    when 1 then add_new_contact
    when 2 then modify_existing_contact
    when 3 then delete_contact
    when 4 then display_all_contacts
    when 5 then search_by_attribute
    when 6 then exit
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
  end

  def modify_existing_contact
    puts "Which contact would you like to modify?"
    mod_contact = false
    until mod_contact != false
      display_all_contacts
      puts "Enter 'id' number you would like to modify"
      prompt = gets.chomp.to_i
      mod_contact = Contact.find(prompt)
    end
    @@current_contact = mod_contact
    prompt = nil
    until prompt == 'y' || prompt =='n'
      puts "Would you like to make change to #{@@current_contact.full_name}? y/n"
      prompt = gets.chomp
    end
    if prompt == 'y'
      @@current_contact.update
      puts "Saved!"
    end
  end

  def delete_contact
    puts "Which contact would you like to delete?"
    search_by_attribute
    # del_contact = @@current_contact
    prompt = nil
    until prompt == 'y' || prompt =='n'
      puts "Would you like to delete #{@@current_contact.full_name}? y/n"
      prompt = gets.chomp
    end
    if prompt == 'y'
      @@current_contact.delete
      puts "You have deleted #{@@current_contact.full_name}!"
    end
  end

  def display_all_contacts
    puts '+' * 5 + 'CONTACTS' + '+' * 5
    Contact.all.each do |contact|
      puts "#{contact.id} | #{contact.full_name} | #{contact.email} | #{contact.note}"
    end
    puts '+' * 20
  end

  def search_by_attribute
    attribute = nil
    value = nil
    search_result = nil
    until attribute == "first name" || attribute == "last name" || attribute == "email" || attribute == "note" || attribute == "id"
      puts "Type 'id', 'first name', 'last name', 'email' or 'note'."
      attribute = gets.chomp
    end
    puts "What is the #{attribute} you are searching for?"
    value = gets.chomp

    if attribute == 'id'
      value = value.to_i
      search_result = Contact.find(value)
    else
      search_result = Contact.find_by(attribute, value)
    end

    if search_result != false
      puts "#{search_result.id} | #{search_result.full_name} | #{search_result.email} | #{search_result.note}"
      @@current_contact = search_result
    end
  end

end

a_crm_app = CRM.new
a_crm_app.main_menu
