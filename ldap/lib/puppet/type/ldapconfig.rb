require 'puppet'
Puppet::Type.newtype(:ldapconfig) do

  # we will group the properies like we did in the rspec file
  # for tag v.0.0.1, thishas no imapct, but we will keep the code
  # grouped when doing specific adjustments

  #
  # string_properties
  #

  newproperty(:attributeoptions) do
  end
  newproperty(:saslsecprops) do
  end
  newproperty(:tlsverifyvlient) do
  end
  newproperty(:loglevel) do
  end
  newproperty(:authzregexp) do
  end

  #
  # int_properties
  #

  newproperty(:concurrency) do
  end
  newproperty(:connmaxpending) do
  end
  newproperty(:connmaxpendingauth) do
  end
  newproperty(:idletimeout) do
  end
  newproperty(:indexsubstrifmaxlen) do
  end
  newproperty(:indexsubstrifminlen) do
  end
  newproperty(:indexsubstranylen) do
  end
  newproperty(:indexsubstranystep) do
  end
  newproperty(:indexintlen) do
  end
  newproperty(:localssf) do
  end
  newproperty(:sockbufmaxincoming) do
  end
  newproperty(:sockbufmaxincomingauth) do
  end
  newproperty(:threads) do
  end
  newproperty(:toolthreads) do
  end
  newproperty(:writetimeout) do
  end

  #
  # path_properties
  #

  newproperty(:logfile) do
  end
  newproperty(:argsfile) do
  end
  newproperty(:pidfile) do
  end
  newproperty(:tlscacertificatepath) do
  end
  newproperty(:tlscertifacicatefile) do
  end
  newproperty(:tlscertifacicatekeyfile) do
  end
  newproperty(:configdir) do
  end
  newproperty(:configfile) do
  end

  #
  # bool_properties
  #

  newproperty(:gentlehup) do
  end
  newproperty(:readonly) do
  end
  newproperty(:reverselookup) do
  end

  #
  # olist_properties
  #

  newproperty(:allows) do
  end
  newproperty(:disallows) do
  end

  #
  # list_properties
  #


  #
  # key_properties
  #
end
