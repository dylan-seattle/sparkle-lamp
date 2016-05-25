# Registry: apache_install
# Description: A command to install php and apache as defined in an
# AWS::AutoScalingGroup::LaunchConfiguration resource. This registry
# needs to be inserted into such a resource to work properly.
SparkleFormation::Registry.register(:apache_install) do
  metadata('AWS::CloudFormation::Init') do
    _camel_keys_set(:auto_disable)
     configSets do
     	default ['update' , 'apache_install' , 'php_install']
     end 

     update do
     	commands('00_get_update') do 
     		command 'sudo apt-get update'
     	end 
     end 

     apache_install do 
     	packages(:apt) do 
     		set!('apache2',[])

     	end 
     	services(:sysvinit) do 
     		apache2 do 
     			enabled true
     			ensureRunning true
     		end 
     	end
     end 

     php_install do 
     	packages(:apt) do 
               set!('php5',[])

               set!('php5-mysql',[])
     		
     		end 
     	end 
     end 

 end 


  
