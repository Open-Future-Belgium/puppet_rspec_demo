puppet_rspec_demo
=================

Learning to write a puppet custom type/provider, starting with the rspec definitions, 
and then step by step coding everything to pass the test.

We are writing an openldap type to setup and reconfigure an openldap server using cn=condig (dynamic config)

All tools should be installed, and initially we setup our module dir tree with 'puppet module generate' 
and issue in the .../modules/ldap

Different steps will be tagged, so one can follow the steps I did in my learning process of all of this.

Tags and there descriptions

tag v0.0  - initial setup and base rspec file properties only: 
  
  - puppet module generated
  - moved rspec_helper out of the way 
  - added lib/puppet/{type|provider}
  - added an .rspec file
  - rspec-puppet-init executed form the module base dir
  - edited spec/type/ldapconfig_spec.rb
  - created lib/puppet/type/ldapconfig.rb (empty type class)
  - executed rspec and captured result in unit_test_result/unit_test_run_001.txt

tag <rspec_ldapconfig> : Initial rspec file
  - based on the puppet internal user_rspec.rb
  - We define which properties we need, and the base of their features
  - we create an empty lib/puppet/type/ldapcopnfig.rb
  - we run rspec

tag <coding_green_failure_one>
  - we start coding the type definition to get our first green rspec result
  - 

and_so_on
  
