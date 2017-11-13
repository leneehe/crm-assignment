gem 'activerecord', '=4.2.10'
require 'active_record'
require 'mini_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'crm.sqlite3')

class Contact < ActiveRecord::Base
  #automatically set up reader and writer methods through mini record
  field :first_name, as: :string
  field :last_name,  as: :string
  field :email,      as: :string
  field :note,       as: :text

  # @@contacts = []
  # @@id = 1

  # This method should initialize the contact's attributes
  # def initialize(first_name, last_name, email, note = "N/A")
  #   @first_name = first_name
  #   @last_name = last_name
  #   @email = email
  #   @note = note
  #   @id = @@id
  #   @@id += 1
  # end

  # This method should call the initializer,
  # store the newly created contact, and then return it
  # def self.create(first_name, last_name, email, note = "N/A")
  #   new_contact = Contact.new(first_name, last_name, email, note)
  #   @@contacts << new_contact
  #   return new_contact
  # end

  # This method should return all of the existing contacts
  # def self.all
  #   return @@contacts
  # end

  # This method should accept an id as an argument
  # and return the contact who has that id
  # def self.find(by_id)
  #   result = false
  #   @@contacts.each do |contact|
  #     if by_id == contact.id
  #       result = contact
  #     end
  #   end
  #   puts "Invalid entry" if result == false
  #   return result
  # end

  # a getter (*get* the value of an attribute) #
  # def email
  #   @email
  # end
  #
  # def id
  #   @id
  # end
  #
  # def first_name
  #   @first_name
  # end
  #
  # def last_name
  #   @last_name
  # end
  #
  # def note
  #   @note
  # end

  # a setter (*set* the value of an attribute) #
  # def note=(note)
  #   @note = note
  # end
  #
  # def first_name=(name)
  #   @first_name = name
  # end
  #
  # def last_name=(name)
  #   @last_name = name
  # end
  #
  # def email=(email)
  #   @email = email
  # end

  # This method should allow you to specify
  # 1. which of the contact's attributes you want to update
  # 2. the new value for that attribute
  # and then make the appropriate change to the contact
  # def update(attribute = nil, value = nil)
  #   if attribute == nil && value == nil
  #     puts "Do you wish to update 'first name', 'last name', 'email', or 'note' for #{full_name}?"
  #     attribute = gets.chomp
  #     # check for valid user input
  #     until attribute == "first name" || attribute == "last name" || attribute == "email" || attribute == "note"
  #       puts "Invalid entry. Type 'first name', 'last name', 'email', or 'note'."
  #       attribute = gets.chomp
  #     end
  #
  #     if attribute == "first name"
  #       puts "Enter new first name:"
  #       value = gets.chomp
  #       first_name = value
  #     elsif attribute == "last name"
  #       puts "Enter new last name:"
  #       value = gets.chomp
  #       last_name = value
  #     elsif attribute == "email"
  #       puts "Enter new e-mail:"
  #       value = gets.chomp
  #       email = value
  #     elsif attribute == "note"
  #       puts "Enter new note:"
  #       value = gets.chomp
  #       note = value
  #     end
  #   end
  #
  #   if attribute == "first name"
  #     self.first_name = value
  #   elsif attribute == "last name"
  #     self.last_name = value
  #   elsif attribute == "email"
  #     self.email = value
  #   elsif attribute == "note"
  #     self.note = value
  #   else
  #     puts "Invalid entry"
  #   end
  #
  # end

  # This method should work similarly to the find method above
  # but it should allow you to search for a contact using attributes other than id
  # by specifying both the name of the attribute and the value
  # eg. searching for 'first_name', 'Betty' should return the first contact named Betty
  # def self.find_by(attribute, value)
  #   if attribute == "first name"
  #     Contact.all.each do |c|
  #       if c.first_name == value
  #         return c
  #       end
  #     end
  #     puts "No results found"
  #     return false
  #   elsif attribute == "last name"
  #     Contact.all.each do |c|
  #       if c.last_name == value
  #         return c
  #       end
  #     end
  #     puts "No results found"
  #     return false
  #   elsif attribute == "email"
  #     Contact.all.each do |c|
  #       if c.email == value
  #         return c
  #       end
  #     end
  #     puts "No results found"
  #     return false
  #   elsif attribute == "note"
  #     Contact.all.each do |c|
  #       if c.note.include? value
  #         return c
  #       end
  #     end
  #     puts "No results found"
  #     return false
  #   else
  #     puts "Invalid entry of attribute."
  #     return false
  #   end
  # end

  # This method should delete all of the contacts
  # def self.delete_all
  #   @@contacts = []
  # end

  def full_name
    return "#{first_name} #{last_name}"
  end

  # This method should delete the contact
  # HINT: Check the Array class docs for built-in methods that might be useful here
  # def delete
  #   @@contacts.delete(self)
  # end

  # Feel free to add other methods here, if you need them.

end

Contact.auto_upgrade!
at_exit do
  ActiveRecord::Base.connection.close
end
