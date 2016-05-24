SfnRegistry.register(:instance_size) do
  ['t2.micro', 't2.small']
end
SfnRegistry.register(:instance_size_default){'t2.micro'}