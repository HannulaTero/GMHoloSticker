

depth = -1000;
gpu_set_ztestenable(true);  // Because in 3D.


// Camera position and target.
camera = camera_create();
viewMatrix = matrix_build_identity();
projMatrix = matrix_build_identity();
orthographic = false;

fov = 60.0;
znear = 1.0;
zfar = 65536.0;

xat = x;
yat = y;
zat = -100.0;

xto = xat + 1.0;
yto = yat;
zto = zat;

xup = 0.0;
yup = 0.0;
zup = 1.0;

len = 512.0;
dir = 0.0;
rot = 0.0;
