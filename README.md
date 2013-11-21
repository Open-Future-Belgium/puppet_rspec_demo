puppet_rspec_demo
=================

Learning to write a puppet custom type/provider, starting with the rspec definitions, 
and then step by step coding everything to pass the test.

We are writing an openldap type to setup and reconfigure an openldap server using cn=condig (dynamic config)

All tools should be installed, and initially we setup our module dir tree with 'puppet module generate' 
and issue in the .../modules/ldap

Different steps will be tagged, so one can follow the steps I did in my learning process of all of this.

Tags and there descriptions

tag <initial_setup> : module tree including my .spec file.
  - puppet module generated, adding the spec and lib subtree
  - rspec-puppet-init executed form the module base dir

tag <rspec_ldapconfig> : Initial rspec file
  - based on the puppet internal user_rspec.rb
  - We define which properties we need, and the base of their features
  - we create an empty lib/puppet/type/ldapcopnfig.rb
  - we run rspec

tag <coding_green_failure_one>
  - we start coding the type definition to get our first green rspec result
  - 

and_so_on
  
