class AddressBook
  attr_accessor :contacts

  def initialize
    @contacts = []
  end

  def add_new_contact(f_name, l_name, email)
    @contacts << Contact.new(f_name, l_name, email)
  end

  def edit_c(f_name, l_name, email, new_info, info_index)
    @contacts.each do |cont|
      if cont.f_name == f_name && cont.l_name == l_name && cont.email == email
        if info_index == 1
          cont.f_name = new_info
        elsif info_index == 2
          cont.l_name = new_info
        elsif info_index == 3
          cont.email = new_info
      end
    end
    end
  end

  def search(keyword)
    matches = []
    @contacts.each do |cont|
      if (cont.f_name.include? keyword) || (cont.l_name.include? keyword) || (cont.email.include? keyword)
        matches << cont
      end
    end
    matches
  end
end