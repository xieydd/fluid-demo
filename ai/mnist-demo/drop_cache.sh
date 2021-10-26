nodes="1.117.238.132 1.117.237.67 1.117.237.191"
for node in $nodes
do
    ssh -i ~/Downloads/xieydd.cer root@$node "echo 3 > /proc/sys/vm/drop_caches"
done
