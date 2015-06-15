require_relative('rolodex.rb')

class CRM
  attr_reader :name

  def self.run(name)
    my_crm = CRM.new(name)
    my_crm.main_menu
  end

  def initialize(name)
    @name = name
    @rolodex = Rolodex.new
  end


  def print_main_menu
    puts "[1] Add a contact"
    puts "[2] Modify a contact"
    puts "[3] Display all contacts"
    puts "[4] Display a contact"
    puts "[5] Display an attribute"
    puts "[6] Delete a contact"
    puts "[7] Exit"
    print "Please select an option from the menu >"
  end

  def select_option(choice)

    case choice
      when 1 then add_contact
      when 2 then modify_contact
      when 3 then display_all_contacts
      when 4 then display_contact
      when 5 then display_attribute
      when 6 then delete_contact
      when 7 then Exit
    end
    
  end

  def main_menu
    puts "Welcome to #{@name}"
    while true
      print_main_menu

      input = gets.chomp.to_i

      select_option(input)
    end
  end

  def add_contact
    puts "Adding a contact"

    print "First name: "
    first_name = gets.chomp.capitalize

    print "Last name: "
    last_name = gets.chomp.capitalize

    print "Email: "
    email = gets.chomp

    print "Notes: "
    notes = gets.chomp

    @rolodex.add_contact(first_name,last_name,email,notes)
    
  end


  def modify_contact
    puts "Modifying a contact"

    loop do
      print "Enter ID: "
      id = gets.chomp.to_i

      @rolodex.display_particular_contact(id)

      puts "Confirm whether this is the ID: #{id} you want to edit. (type: Y/N)"
      confirm = gets.chomp.upcase

      if confirm == "Y"
        print "Which attribute would you like to edit? >"
        to_edit = gets.chomp.capitalize
        print "Enter edit>"
        edit_info = gets.chomp
        @rolodex.modify_contact(id, to_edit, edit_info)
        break
      end
    end


  
  end

  def display_all_contacts
    @rolodex.display_all_contacts.each do |contact|
      puts "#{contact.id} -- #{contact.first_name} #{contact.last_name} -- #{contact.email} -- #{contact.notes}"
    end
    
  end

  def display_contact
    print "Enter contact ID:"

    contact_input = gets.chomp.to_i
    @rolodex.display_particular_contact(contact_input)
  end

  def display_attribute
    print "Enter attribute to filter:"

    attribute = gets.chomp.capitalize

    @rolodex.display_info_by_attribute(attribute)

  end

  def delete_contact
    puts "Deleting contact"

    loop do
    print "Enter contact ID:"
    delete_id = gets.chomp.to_i

    @rolodex.display_particular_contact(delete_id)
    
    puts "Confirm whether this is the contact you want to delete. (type: Y/N)"
      confirm = gets.chomp.upcase

      if confirm == "Y"
        @rolodex.delete_contact(delete_id)
        break
      end
    end
    
  end
end

CRM.run("Bitmaker CRM")

