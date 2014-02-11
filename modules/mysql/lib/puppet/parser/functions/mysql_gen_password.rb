# generate random password 
require 'securerandom'

module Puppet::Parser::Functions
  newfunction(:mysql_gen_password, :type => :rvalue, :doc => <<-EOS
    Returns random password
    EOS
  ) do |args|

    raise(Puppet::ParseError, "mysql_gen_password(): Wrong number of arguments " +
      "given (#{args.size} for 0)") if args.size > 0

    SecureRandom.base64()

  end
end
