require 'puppet'
require 'puppet/property/boolean'
require 'puppet/property/ordered_list'

Puppet::Type.newtype(:ldapconfig) do

  @doc = "The config backend manages all of the configuration information
    for the slapd(8) daemon. This configuration information is also used
    by the SLAPD tools slapacl(8), slapadd(8), slapauth(8), slapcat(8),
    slapdn(8), slapindex(8), and slaptest(8).

    The config backend is backward compatible with the older slapd.conf(5)
    file but provides the ability to change the configuration dynamically
    at runtime. If slapd is run with only a slapd.conf file dynamic changes
    will be allowed but they will not persist across a server restart. Dynamic
    changes are only saved when slapd is running from a slapd.d configuration
    directory.

    Unlike other backends, there can only be one instance of the config backend,
    and most of its structure is predefined. The root of the database is hardcoded
    to cn=config and this root entry contains global settings for slapd"

  # we will group the properies like we did in the rspec file
  # for tag v.0.0.1, thishas no imapct, but we will keep the code
  # grouped when doing specific adjustments

  newproperty(:ensure, :parent => Puppet::Property::Ensure) do
    desc "The basic state that the object shoul be in"

    # if the ensure property is 'present', then this will trigger
    # the event :config_created.  The logic is written inn  the provider code
    # because implentation will differ from distro/OS/Platform
    newvalue(:present, :event => :config_created) do
      provider.create
    end
    newvalue(:absent, :event => :config_removed) do
      provider.delete
    end

    # here we define the default value depending if the reaource is managed or not.

    defaultto do
      if @resource.managed?
        :present
      else
        nil
      end
    end

    def retrieve
      if provider.exists?
        :present
      else
        :absent
      end
    end

  end

  #
  # string_properties
  #

  newproperty(:attributeoptions) do
    desc "Define tagging attribute options or option tag/range prefixes. Options must not end with \'-\', prefixes must end with \'-\'"
  end

  # we need to allow multiple values to be set, array_matching defaults to first
  newproperty(:saslsecprops, :array_matching => :all) do
    desc "The SASL secprops to apply. Defaults to \'noanonymous,noplain\'."
    defaultto ['noanonymous', 'noplain']
    # we cannot use newvalues, because we have specific validations depending on the values used
    # order should not be  important
    validate do | value |
      # we fail on the first fail
      case value
      when 'none', 'noanonymous', 'noplain', 'noactive', 'nodict', 'forwardsec', 'passcred'
        # value is accepted
      when /^minssf=/,/^maxssf=/
        case value.split('=',2)[1]
        when "0", "1", "56", "112", "128"
          # we have to validate the factor
        else
          raise ArgumentError, "property saslsecprops : #{value}= should have a value of [0|1|56|112|128]"
        end
      when /^maxbufsize=/
        # The Integer() function raises an error if it has a 'non' decimal string
        totest = Integer(value.split('=',2)[1])
        if totest >= 0 || totest <= 65536
          # passed
        else
          raise ArgumentError, "property saslsecprops : #{value}= must be between 0 and 65536. See man slapd-config"
        end
      else
        raise ArgumentError, "property saslsecprops : #{value} not allowed. See man slapd-config"
      end
    end
  end

  newproperty(:tlsverifyclient) do
    # here we can use the newvalues for validation.
    # for single values params, be ware that by default Symbols are used
    # so everything is converted
    desc "Specifies what checks to perform on client certificates in an incoming TLS session, if any"
    defaultto 'never'
    newvalues('never','allow','try','demand','hard','true')
  end

  newproperty(:loglevel) do
    desc " Specify the level at which debugging statements and operation statistics should be syslogged (currently logged to the syslogd(8) LOG_LOCAL4 facility)."
  end
  newproperty(:authzregexp, :array_matching => :all) do
    desc "An array of authz-regexps"
  end

  #
  # int_properties
  #

  newproperty(:concurrency) do
    desc "Specify  a  desired  level  of  concurrency."
    # if 0, this attirbute will not be set
    defaultto 0
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:connmaxpending) do
    desc "Specify  the  maximum  number  of pending requests for an anonymous session."
    defaultto 100
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:connmaxpendingauth) do
    desc "Specify the maximum number of pending requests for an authenticated session."
    defaultto 1000
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:idletimeout) do
    desc "Specify the number of seconds to wait before forcibly closing an idle client connection."
    # A setting of 0 disables this feature
    defaultto 0
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:indexsubstrifmaxlen) do
    desc "Specify  the  maximum  length  for  subinitial  and  subfinal  indices."
    defaultto 4
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:indexsubstrifminlen) do
    desc "Specify  the  minimum length for subinitial and subfinal indices."
    defaultto 2
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:indexsubstranylen) do
    desc "Specify the length used for subany indices."
    defaultto 4
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:indexsubstranystep) do
    desc "Specify the steps used in subany index lookups."
    defaultto 2
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:indexintlen) do
    desc "Specify  the  key  length for ordered integer indices."
    defaultto 4
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:localssf) do
    desc "Specifies  the  Security  Strength  Factor  (SSF) to be given local LDAP sessions"
    defaultto 71
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:sockbufmaxincoming) do
    desc "Specify the maximum incoming LDAP PDU size for anonymous sessions"
    defaultto 262143
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:sockbufmaxincomingauth) do
    desc "Specify the maximum incoming LDAP PDU size for authenticated sessions"
    defaultto 4194303

    munge do |value|
      Integer(value)
    end

  end
  newproperty(:threads) do
    desc "Specify the maximum size of the primary thread pool."
    defaultto 16

    validate do |value|
      if Integer(value) < 2
        raise ArgumentError, "Value of property \"threads\" must be equal or greater than 2"
      end
    end

    munge do |value|
      Integer(value)
    end

  end
  newproperty(:toolthreads) do
    desc "Specify the maximum number of threads to use in tool mode."
    defaultto 1
    munge do |value|
      Integer(value)
    end
  end
  newproperty(:writetimeout) do
    desc "Specify the number of seconds to wait before forcibly closing a connection with an outstanding write."
    # a setting of '0' disables this function
    defaultto 0
    munge do |value|
      Integer(value)
    end
  end

  #
  # path_properties
  #

  newproperty(:logfile) do
    desc "Specify  a  file  for recording debug log messages."
    defaultto "stderr"
    validate do | value |
      if ! (value =~ /^std/)
        unless Pathname.new(value).absolute?
          fail("Invalid logfile given - Absolute path required - given #{value}")
        end
      end
    end
  end

  newproperty(:argsfile) do
    desc 'The (absolute) name of a file that will hold the slapd servers command line (program name and
              options).'
    defaultto "/var/run/openldap/slapd.args"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid argsfile given - Absolute path required - given #{value}")
      end
    end
  end

  newproperty(:pidfile) do
    desc "The (absolute) name of a file that will hold the slapd servers process ID"
    defaultto "/var/run/openldap/slapd.pid"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid pidfile given - Absolute path required - given #{value}")
      end
    end
  end

  newproperty(:tlscertificatefile) do
    desc "Specifies the file that contains the slapd server certificate."
    defaultto "/etc/openldap/certs/openldap.pem"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid tlscertificatefile given - Absolute path required - given #{value}")
      end
    end
  end

  newproperty(:tlscertificatekeyfile) do
    desc "Specifies the file that contains the slapd server private key that matches the certificate stored in the olcTLSCertificateFile file"
    defaultto "/etc/openldap/certs/password"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid tlscertificatekeyfile given - Absolute path required - given #{value}")
      end
    end
  end

  newproperty(:configdir) do
    desc "The (absolete) path of the directory where the dynamic configuration files reside"
    defaultto "/etc/openldap/slapd.d"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid configdir given - Absolute path required - given #{value}")
      end
    end
  end

  newproperty(:configfile) do
    desc "Obslote, and not used by in dynamic ldap configuration"
    defaultto "/etc/openldap/slapd.conf.bak"
    validate do | value |
      unless Pathname.new(value).absolute?
        fail("Invalid configfile given - Absolute path required - given #{value}")
      end
    end
  end

  #
  # bool_properties
  #
  # When setting defaultto vaules, use Symbols to make it work, otherwise, null will be returned
  #

  newproperty(:gentlehup, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'A  SIGHUP signal will only cause a "gentle" shutdown-attempt'
    defaultto :false
  end
  newproperty(:readonly, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc "This option puts the database into \"read-only\" mode. Any attempts to modify the database will return an \"unwilling to perform\" error"
    defaultto :false
  end
  newproperty(:reverselookup, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc "Enable/disable client name unverified reverse lookup"
    defaultto :false
  end

  #
  # olist_properties
  #

  newproperty(:allows, :parent => Puppet::Property::OrderedList) do
    desc "Specify  a set of features to allow (default none)."
  end
  newproperty(:disallows, :parent => Puppet::Property::OrderedList) do
    desc "Specify  a set of features to disallow"
  end

  #
  # list_properties
  #


  #
  # key_properties
  #

  #
  # Parameter entries are grouped here
  #

  newparam( :name , :namevar => true) do
    desc "The ldap config name. should always be config, or config followed wit a number"
    defaultto 'config0'
  end


  #
  # Global functions used in the Type definition
  # Code that is needed to help validating the properties and parameters
  #

  def exists?
    provider.exists?
  end
end
