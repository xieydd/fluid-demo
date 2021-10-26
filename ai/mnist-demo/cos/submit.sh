arena --loglevel info submit pytorch \
    --name=mnist-cos \
    --gpus=0 \
    --workers=3 \
    --image=ccr.ccs.tencentyun.com/kubeflow-oteam/pytorch:1.5.1-cuda10.1-cudnn7-runtime-tensorboard \
    --data=mnist-cos-pvc:/cos \
    --sync-mode=git \
    --sync-source=https://gitee.com/xieyuandong/mnist-pytorch.git \
    "python /root/code/mnist-pytorch/mnist.py --backend gloo --data=/cos"
