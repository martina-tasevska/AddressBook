require_relative 'address_book'
require_relative 'contact'
require_relative 'invalid_input'

book = nil
menu_items = "Please choose what you want to do:\nAdd new contact - 1\nEdit a contact's info - 2\nDelete existing contact - 3\nSearch - 4\nExit - 5"
menu_items_edit = "Choose what to edit:\nFirst name - 1\nLast name - 2\nEmail - 3\nDone editing - d"

def check_error(input, book)
  raise InvalidInput unless input.to_i < book.contacts.length && input.to_i >= 0
end

def iterate(book, index = 0)
  book.contacts.each do |cont|
    puts "#{cont} - #{index}"
    index = index.to_i + 1
  end
end

def add_contact(book)
  puts 'Enter first name'
  f_name = gets
  puts 'Enter last name'
  l_name = gets
  puts 'Enter email'
  email = gets
  book.add_new_contact(f_name, l_name, email)
  puts 'New contact added.'
end

def edit_contact(book, menu_items_edit)
  iterate(book)
  puts 'Choose a contact to edit'
  input1 = gets
  begin
    check_error(input1.to_i, book)
  rescue InvalidInput => e
    puts e.msg
    return
  end
  c = book.contacts.at(input1.to_i)
  puts menu_items_edit
  loop do
    input2 = gets.chomp
    break if input2.chomp.eql? 'd'

    begin
      raise InvalidInput unless ["1", "2", "3"].include? input2
    rescue InvalidInput => e
      puts e.msg
      break
    end

    puts 'Enter new information:'
    new_info = gets.chomp
    book.edit_c(c.f_name, c.l_name, c.email, new_info, input2.to_i)
    puts "Edited contact: #{book.contacts.at(input1.to_i)}"
  end
end

def delete_contact(book)
  loop do
    iterate(book)
    if book.contacts.none?
      puts 'No more contacts to delete'
      break
    end
    puts 'Choose a contact to delete'
    puts 'Done deleting - d'

    begin
      input1 = gets
      check_error(input1, book)
    rescue => e
      puts e.msg
      return
    end

    break if input1.chomp.eql? 'd'

    book.contacts.delete_at(input1.to_i)
  end
end

def search_contact(book)
  puts 'Enter keyword'
  keyword = gets.chomp
  matches = book.search(keyword)
  puts 'No matches' if matches.none?
  matches.each do |match|
    puts match.to_s
  end
end

puts menu_items

loop do
  input = gets
  book = AddressBook.new if book.nil?

  if input.chomp.eql? '1'
    add_contact(book)
  elsif input.chomp.eql? '2'
    edit_contact(book, menu_items_edit)
  elsif input.chomp.eql? '3'
    delete_contact(book)
  elsif input.chomp.eql? '4'
    search_contact(book)
  elsif input.chomp.eql? '5'
    exit
  else
    begin
      raise InvalidInput
    rescue InvalidInput => e
      puts e.msg
    end
  end
end