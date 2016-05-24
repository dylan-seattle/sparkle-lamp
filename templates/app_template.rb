SparkleFormation.new('sparkle_lamp').load(:base).overrides do 
	description 'Build 1:1 Apache: Mysql ec2instances' 

	#Set up reusable values 
	web_protocol = 'tcp'
	web_port = '80'

	db_protocol = 'tcp'
	db_port = '3306'

	#Create the security groups
	dynamic!(:security_group, 'db')
	dynamic!(:security_group, 'web')
	  # Create ingress rules
  # This rule to allow access to the db sg from the web sg.
    dynamic!(:security_group_ingress, 'db_web',
	           :port => db_port,
	           :ip_protocol => db_protocol,
	           :group_name => ref!(:db_security_group),
	           :source_group_name => ref!(:web_security_group)
	  )

	  # This rule to allow access to the app nodes from the public, the
	  # elb or from other app nodes.
	dynamic!(:security_group_ingress, 'web_public',
	           :port => web_port,
	           :ip_protocol => web_protocol,
	           :group_name => ref!(:web_security_group),
	           :cidr_ip => '0.0.0.0/0'
	  )
	#Create sg ingress rules 
	# allow access to the db security group from the web security group
	dynamic!(:launch_configuration, 'db' , 
			 :image_id => 'ami-9abea4fb',
			 :instance_type => 't2.micro',
			 :security_group => ref!(:db_security_group)
			 ) 
	# install mysql in db Autoscaling Group 

	resources(:db_launch_configuration) do 
		registry!(:mysql_install)
	end 

	# Create the Autoscaling LaunchConfiguration for the Web Autoscaling Group 
	dynamic!(:launch_configuration, 'web',
			:image_id => 'ami-9abea4fb',
			:instance_type => 't2.micro',
			:security_group => ref!(:web_security_group) 
		) 

	# install apache on the web heads 
	resources(:web_launch_configuration) do 
		registry!(:apache_install)
	end 

	 # Create the db asg
  dynamic!(:auto_scaling_group, 'db',
           :launch_configuration_name => ref!(:db_launch_configuration),
           :size => 1
           #:value => 'db'
  )

  # Create the web asg and load balance it
  dynamic!(:auto_scaling_group, 'web',
           :launch_configuration_name => ref!(:web_launch_configuration),
           # change size to larger '#' if want bigger group
           :size => 1,
           #:value => 'web',
           # set the value to 'true' if want Load Balancer
           :load_balance => true 
  )

end