# Registry : mysql_install 
# Description : Install mysql on the db for ubuntu/debian based images 

SparkleFormation::Registry.register(:mysql_install) do 
	metadata('AWS::CloudFormation::Init') do 
		_camel_keys_set(:auto_disable) 

	     configSets do
	     	default ['update' , 'mysql_install']
	     end 

	     update do
	     	commands('00_get_update') do 
	     		command 'sudo apt-get update'
	     	end 
	     end 

	     mysql_install do 
	     	packages do
	     		apt do 
	     			set!('mysql-server',[])
	     			end  
	     	end 
	     	services(:sysvinit) do 
	     		mysql do 
	     			enabled true
	     			ensureRunning true
	     		end 
	     	end
	     end
	 end 
	end 
