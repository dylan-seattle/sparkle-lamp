SparkleFormation.new('web_load_balancer').load(:base).overrides do

  description 'Lamp load balancer'
 
  # Create the load balancer resource and use defaults
  dynamic!(:load_balancer, 'web')

end