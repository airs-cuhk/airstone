## Workflow to run the src

We utilize LIO-SAM as the front-end and KITTI dataset to extract corresponding lidar and IMU data from lio-sam-output.txt, transmitting it as input to our hardware. Note that this design does not include a sliding window module, thus requiring manual input of scaling factors.

In the final, you can generate the image from the data.txt like this.

![Ground](./Ground.png)