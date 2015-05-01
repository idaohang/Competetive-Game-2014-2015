function [ cores_new ] = tt_core_leave_axis( cores, axis )
if axis ~= 1 && axis ~= 2 && axis ~= 3
    error('Wrong axis')
end

core = cores{15};
core = core(:,:,axis);
cores_new = cores;
cores_new{15} = core;
end

