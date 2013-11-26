puppet_rspec_demo
=================

Learning to write a puppet custom type/provider, starting with the rspec definitions,
and then step by step coding everything to pass the test.

We are writing an openldap type to setup and reconfigure an openldap server using cn=condig (dynamic config)

All tools should be installed, and initially we setup our module dir tree with 'puppet module generate'
and issue in the .../modules/ldap

Different steps will be tagged, so one can follow the steps I did in my learning process of all of this.


The dir structure :

├── ldap
│   ├── doc                  The text of this tutorial (to be written soon)
│   ├── lib                  Puppet - The puppet extention dirtree
│   ├── manifests            Puppet - The manifest dir 
│   ├── Modulefile           Puppet - Module dependency etc file (see  puppet forge docs)
│   ├── Rakefile             Rspec  - created by rspec-puppet-init (check also .rspec file)
│   ├── README               Puppet Ldap module Readme file
│   ├── spec                 Puppet - rspec dirtree
│   ├── tests                Puppet - smoke test 
│   └── unit_test_result     Output from the 'rake spec' command at thhe end of every tag
└── README.mda               This file


Tags and there descriptions

tag v0.0.0  - initial setup and base rspec file properties only:

  - puppet module generated
  - moved rspec_helper out of the way 
  - added lib/puppet/{type|provider}
  - added an .rspec file
  - rspec-puppet-init executed form the module base dir
  - edited spec/type/ldapconfig_spec.rb
  - created lib/puppet/type/ldapconfig.rb (empty type class)
  - executed rspec and captured result in unit_test_result/unit_test_run_001.txt

tag v0.0.1 - Writing our ldaconig.rb type code

  - getting the rspec red into green.This is the only goal.
    We will code only that waht is needed to pass the tests.
    If we want extra features added, we will write them down for the next
    cycle.
  - now, we will concentrate on the on the modules/ldap/lib/puppet/type/ldapconfig.rb file
  - Going to all green, doing one red step by step

subtag - v.0.0.1.0

  - step one :  put all 
      newproperty(:property) do
      end
   blocks in the code.
  - run 'rake rspec'
  - etc ..
  - 73 examples, 40 failures
  - Errata : first rake spec failed, because we haveConfigdir and configfile
    declared on two places in the rspec file.
    (int_properties and path_properties)
    gives an parse error.
    - logLevel and attributeOptions -> capital in both rspec and type.rb.
      this must be all lowercase

Subtag - v0.0.1.1

  - still 7 failures in the rspec.
  - Adding the puppet data structures to the appropriate properties
    - require 'puppet/parameter/boolean'
    - require 'puppet/property/ordered_list'
    - We have boolean, and ordered_lists (see the puppetcode @ /usr/share/ruby/vendor_ruby/puppet/property/*.rb)  No docs found to use thes.
    -  newproperty(:readonly, :boolean => true, :parent => Puppet::Property::Boolean)
    - newproperty(:allows, :parent => Puppet::Property::OrderedList)
    -  how to use this in the code, will become clear in the nexr steps 
  - errate in spec -> typo in should (again)

  - it seems we have conflicting rspec here : 
    - should have a gentlehup property (FAILED - 2) 
    - should have a ordered_list allows
      - both should pass !!

    - TODO --> short tutorial how to use pry for debugging purposes. http://pryrepl.org/
    - Result of this run : 2 fails:
      - should be able to create an instance (FAILED - 1)
      - should delegete existence questions to its provider (FAILED - 2)

subtag v0.0.1.2

  - pass the 'should be able to create an instance (FAILED - 1)' test.
    - every type should have a name/namevar.  
    - in this case, we use a parameter, and make it also the namevar)
    - normaly, only one configuration wil be used on an ldap server,
      but i keep the option open to run multiple ldap instances on
      the same server, each having #ports and #configdirs.
  -docs about namevar etc in the booklet 'Puppet type and Providers"

subtag v0.0.1.3

  - Make the last failure pass : should delegete existence questions to its provider (FAILED - 1)
  - In this test, we introduce another parameter :ensure.
  - For a start we check that the resource should be present 
  - ensure property --> special case.  Also use a parent class (ensure)
  - new feature -> event : :config_created, we will check if there is 
    a file cn=config.ldif in the /etc/openldap/<config dir>
  - it is the provider code who will handle this, but that piece of
    code is not written yet, therfore we use the stubbing feature from rspec
  - for his to work, we had to add some calls to the providercode.  Have to
    look this up in the docs/code what this is all about.  (for now on,
    just copy/paste and hoping it works)
  - end it works, but we should really explain what we have done.

tag v0.0.2.0

  - adding more tests to the rspec files :
    - form the ldap man page, adding defaults tot the different properties.
      - int_properties
        - test that default values are all integer
        - test that all int_properties return an integer value
        - test that all int_properties fails if provided with a string
        - test that all int-properties succeed when provided an value as string
  - One test pass, the one assigning an integer, because no checks are done yet (no code yet)

tag v0.0.2.1

  - Adding th code to make the tests pass :
    - adding the default values
    - let it fail when non integer is given
    - convert number strings to integer


tag v0.0.2.2

      - boolean properties
        - test that all booleans return  true/false
        - test that all booleans raise an error if not

tag v0.0.2.4

      - path-properties
        - should all be absolete paths, else raise error
      - string properties
        - tests depends on the property, is it requires,  restricted value range
      - olist-properties
        - check for allowed values
        - special check in this case are needed


 
and_so_on
  
