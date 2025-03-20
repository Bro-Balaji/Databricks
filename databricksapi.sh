curl -X GET "https://databricks-hostname/api/2.1/clusters/list" \
     -H "Authorization: Bearer <token>"


curl -X GET "https://databricks-hostname/api/2.0/policies/clusters/list" \
      -H "Authorization: Bearer <token>"

curl -X GET "https://databricks-hostname/api/2.2/jobs/list" \
      -H "Authorization: Bearer <token>"


curl -X GET "https://databricks-hostname/api/2.1/jobs/runs/list" \
       -H "Authorization: Bearer <token>"


curl -X GET "https://databricks-hostname/api/2.0/policies/clusters/list" \
        -H "Authorization: Bearer <token>"


curl -X POST "https://databricks-hostname/api/2.1/clusters/resize" \
     -H "Authorization: Bearer <token>" \
     -H "Content-Type: application/json" \
     -d '{
           "cluster_id": "", 
           "autoscale": {
             "min_workers": 1,
             "max_workers": 2
           }
         }'


curl -X GET "https://databricks-hostname/api/2.1/clusters/list-node-types" \
       -H "Authorization: Bearer <token>"


curl -X POST https://databricks-hostname/api/2.0/instance-pools/edit \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
        "instance_pool_id": "",
        "instance_pool_name": "devops",
        "min_idle_instances": 0,
        "max_capacity": 6
      }'

