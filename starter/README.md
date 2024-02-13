# CD12352 - Infrastructure as Code Project Solution
# Miro

## Spin up instructions
```
./run.sh create network-stack network.yml network-parameters.json
./run.sh create udagram-stack udagram.yml udagram-parameters.json
```

## Tear down instructions
```
./run.sh delete network-stack 
./run.sh delete udagram-stack 
```

## Other considerations
Region is fixed to "eu-central-1" because I had some proxy issues.