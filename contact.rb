class Contact

  attr_accessor :f_name, :l_name, :email

  def initialize(f_name, l_name, email)
    @f_name = f_name.chomp
    @l_name = l_name.chomp
    @email = email.chomp
  end

  def to_s
    s = "#{@f_name} #{@l_name} #{@email}"
  end
end