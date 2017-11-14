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
    when 6 then abort('Goodbye!')
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

    Contact.create(
      first_name: first_name,
      last_name:  last_name,
      email:      email,
      note:       note
    )
  end

  def modify_existing_contact
    puts "Which contact would you like to modify?"
    mod_contact = nil
    until mod_contact != nil
      display_all_contacts
      puts "Enter 'id' number you would like to modify"
      prompt = gets.chomp.to_i

      Contact.all.each do |c|
        if c.id == prompt
          mod_contact = Contact.find(prompt)
        end
      end
      puts "Id does not exist!"
    end

    @@current_contact = mod_contact
    prompt = nil
    until prompt == 'y' || prompt =='n'
      puts "Would you like to make change to #{@@current_contact.full_name}? y/n"
      prompt = gets.chomp
    end
    if prompt == 'y'

      puts "Do you wish to update 'first name', 'last name', 'email', or 'note' for #{@@current_contact.full_name}?"
      attribute = gets.chomp
      # check for valid user input
      until attribute == "first name" || attribute == "last name" || attribute == "email" || attribute == "note"
        puts "Invalid entry. Type 'first name', 'last name', 'email', or 'note'."
        attribute = gets.chomp
      end

      if attribute == "first name"
        puts "Enter new first name:"
        value = gets.chomp
        @@current_contact.first_name = value
      elsif attribute == "last name"
        puts "Enter new last name:"
        value = gets.chomp
        @@current_contact.last_name = value
      elsif attribute == "email"
        puts "Enter new e-mail:"
        value = gets.chomp
        @@current_contact.email = value
      elsif attribute == "note"
        puts "Enter new note:"
        value = gets.chomp
        @@current_contact.note = value
      else
        puts "Invalid entry"
      end

      @@current_contact.save
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
    # search_result = nil
    until attribute == "first name" || attribute == "last name" || attribute == "email" || attribute == "note" || attribute == "id"
      puts "Type 'id', 'first name', 'last name', 'email' or 'note'."
      attribute = gets.chomp
    end

    if attribute == 'id'
      search_result = nil
      until search_result != nil
        display_all_contacts
        puts "Enter 'id' number"
        value = gets.chomp.to_i

        Contact.all.each do |c|
          if c.id == value
            search_result = Contact.find(value)
          end
        end

      end

    else
      puts "What is the #{attribute} you are searching for?"
      value = gets.chomp
      attribute.gsub!(' ', '_')
      search_result = Contact.find_by(attribute => value)
    end

    if search_result != nil
      puts "#{search_result.id} | #{search_result.full_name} | #{search_result.email} | #{search_result.note}"
      @@current_contact = search_result
    else
      puts "No matched result found."
    end
  end

end

a_crm_app = CRM.new
a_crm_app.main_menu
