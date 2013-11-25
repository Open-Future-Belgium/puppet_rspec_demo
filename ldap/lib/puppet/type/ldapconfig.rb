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

  #
  # string_properties
  #

  newproperty(:attributeoptions) do
    desc "Define tagging attribute options or option tag/range prefixes. Options must not end with '-', prefixes must end with '-'"
  end
  newproperty(:saslsecprops) do
    desc "The SASL secprops to apply. Defaults to 'noplain,noanonymous'."
  end
  newproperty(:tlsverifyclient) do
    desc "Specifies what checks to perform on client certificates in an incoming TLS session, if any"
  end
  newproperty(:loglevel) do
    desc " Specify the level at which debugging statements and operation statistics should be syslogged (currently logged to the syslogd(8) LOG_LOCAL4 facility)."
  end
  newproperty(:authzregexp) do
    desc "An array of authz-regexps"
  end

  #
  # int_properties
  #

  newproperty(:concurrency) do
    desc "Specify  a  desired  level  of  concurrency."
  end
  newproperty(:connmaxpending) do
    desc "Specify  the  maximum  number  of pending requests for an anonymous session."
  end
  newproperty(:connmaxpendingauth) do
    desc "Specify the maximum number of pending requests for an authenticated session."
  end
  newproperty(:idletimeout) do
    desc "Specify the number of seconds to wait before forcibly closing an idle client connection."
  end
  newproperty(:indexsubstrifmaxlen) do
    desc "Specify  the  maximum  length  for  subinitial  and  subfinal  indices."
  end
  newproperty(:indexsubstrifminlen) do
    desc "Specify  the  minimum length for subinitial and subfinal indices."
  end
  newproperty(:indexsubstranylen) do
    desc "Specify the length used for subany indices."
  end
  newproperty(:indexsubstranystep) do
    desc "Specify the steps used in subany index lookups."
  end
  newproperty(:indexintlen) do
    desc "Specify  the  key  length for ordered integer indices."
  end
  newproperty(:localssf) do
    desc "Specifies  the  Security  Strength  Factor  (SSF) to be given local LDAP sessions"
  end
  newproperty(:sockbufmaxincoming) do
    desc "Specify the maximum incoming LDAP PDU size for anonymous sessions"
  end
  newproperty(:sockbufmaxincomingauth) do
    desc "Specify the maximum incoming LDAP PDU size for authenticated sessions"
  end
  newproperty(:threads) do
    desc "Specify the maximum size of the primary thread pool."
  end
  newproperty(:toolthreads) do
    desc "Specify the maximum number of threads to use in tool mode."
  end
  newproperty(:writetimeout) do
    desc "Specify the number of seconds to wait before forcibly closing a connection with an outstanding write."
  end

  #
  # path_properties
  #

  newproperty(:logfile) do
    desc "Specify  a  file  for recording debug log messages."
  end
  newproperty(:argsfile) do
    desc 'The (absolute) name of a file that will hold the slapd servers command line (program name and
              options).'
  end
  newproperty(:pidfile) do
    desc "The (absolute) name of a file that will hold the slapd servers process ID"
  end
  newproperty(:tlscacertificatepath) do
    desc "Specifies the path of a directory that contains Certificate Authority certificates in separate individual files."
  end
  newproperty(:tlscertificatefile) do
    desc "Specifies the file that contains the slapd server certificate. "
  end
  newproperty(:tlscertificatekeyfile) do
    desc "Specifies the file that contains the slapd server private key that matches the certificate stored in the olcTLSCertificateFile file."
  end
  newproperty(:configdir) do
    desc "The (absolete) path of the directory where the dynamic configuration files reside"
  end
  newproperty(:configfile) do
    desc "Obslote, and not used by in dynamic ldap configuration"
  end

  #
  # bool_properties
  #

  newproperty(:gentlehup, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc 'A  SIGHUP signal will only cause a "gentle" shutdown-attempt'
  end
  newproperty(:readonly, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc "This option puts the database into \"read-only\" mode. Any attempts to modify the database will return an \"unwilling to perform\" error"
  end
  newproperty(:reverselookup, :boolean => true, :parent => Puppet::Property::Boolean) do
    desc "Enable/disable client name unverified reverse lookup"
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
end
