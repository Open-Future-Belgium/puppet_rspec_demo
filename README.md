puppet_rspec_demo
=================

Learning to write a puppet custom type/provider, starting with the rspec definitions,
and then step by step coding everything to pass the test.

We are writing an openldap type to setup and reconfigure an openldap server using cn=condig (dynamic config)

All tools should be installed, and initially we setup our module dir tree with 'puppet module generate'
and issue in the .../modules/ldap

Different steps will be tagged, so one can follow the steps I did in my learning process of all of this.

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


and_so_on
  
