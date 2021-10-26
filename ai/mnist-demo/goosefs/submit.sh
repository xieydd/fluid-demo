arena --loglevel info submit pytorch \
    --name=mnist-goosefs \
    --gpus=0 \
    --workers=2 \
    --image=registry.cn-beijing.aliyuncs.com/ai-samples/pytorch-with-tensorboard:1.5.1-cuda10.1-cudnn7-runtime \
    --data=mnist:/goosefs \
    --sync-mode=git \
    --sync-source=https://gitee.com/xieyuandong/mnist-pytorch.git \
    "python /root/code/mnist-pytorch/mnist.py --backend gloo --data=/goosefs/mnist"
