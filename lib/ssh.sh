
list_instances() {
  oci compute instance list \
    --compartment-id "$TENANCY_OCID" \
    --region "$REGION" \
    --query "data[*].{NAME:\"display-name\",STATE:\"lifecycle-state\",ID:id}" \
    --output table
}

tf_ssh() {
  NAME="$1"

  ID=$(oci compute instance list \
    --compartment-id "$TENANCY_OCID" \
    --region "$REGION" \
    --query "data[?\"display-name\"=='$NAME'].id | [0]" \
    --output json | tr -d '"')

  echo "⏳ Fetching public IP..."

  IP=""
  for i in {1..30}; do
    IP=$(oci compute instance list-vnics \
      --instance-id "$ID" \
      --region "$REGION" \
      --query "data[0].\"public-ip\"" \
      --output json | tr -d '"')

    [[ -n "$IP" && "$IP" != "null" ]] && break
    sleep 5
  done

  echo "🔗 SSH → $IP"
  ssh ubuntu@"$IP" -i ~/.ssh/id_rsa
}

destroy_instance() {
  NAME="$1"

  ID=$(oci compute instance list \
    --compartment-id "$TENANCY_OCID" \
    --region "$REGION" \
    --query "data[?\"display-name\"=='$NAME'].id | [0]" \
    --output json | tr -d '"')

  oci compute instance terminate --instance-id "$ID" --force
  echo "✅ deleted $NAME"
}
