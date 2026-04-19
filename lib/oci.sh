
create_instance() {
  NAME="$1"

  [[ -z "$TENANCY_OCID" ]] && {
    echo "❌ TENANCY_OCID not set"
    exit 1
  }

  echo "🔧 Resolving subnet..."
  resolve_subnet

  echo "🔍 Selecting SAFE Ubuntu image..."
  pick_image

  echo "🚀 Deploying $NAME..."
  tf_deploy "$NAME"
}

resolve_subnet() {
  if [[ -f "$SUBNET_CACHE" ]]; then
    SUBNET_ID=$(cat "$SUBNET_CACHE")
    return
  fi

  SUBNET_ID=$(oci network subnet list \
    --compartment-id "$TENANCY_OCID" \
    --region "$REGION" \
    --all \
    --query "data[?\"prohibit-public-ip-on-vnic\"==\`false\`].id | [0]" \
    --output json | tr -d '"')

  echo "$SUBNET_ID" > "$SUBNET_CACHE"
}

# =========================
# FIXED UBUNTU IMAGE PICKER
# =========================
pick_image() {
  IMAGE_ID=$(oci compute image list \
    --compartment-id "$TENANCY_OCID" \
    --region "$REGION" \
    --all \
    --query "data[?contains(\"display-name\", 'Canonical-Ubuntu-22.04') && \"operating-system\"=='Canonical Ubuntu'] | sort_by(@, &\"time-created\") | [-1].id" \
    --output json | tr -d '"')

  IMAGE_NAME=$(oci compute image get \
    --image-id "$IMAGE_ID" \
    --query "data.\"display-name\"" \
    --output json | tr -d '"')

  echo "📦 IMAGE: $IMAGE_NAME"
}
