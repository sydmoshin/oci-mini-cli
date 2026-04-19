REGION="us-ashburn-1"
TENANCY_OCID="${TENANCY_OCID:-}"
SUBNET_CACHE="./.subnet.cache"
SHAPE="VM.Standard.E2.1.Micro"

# 🔐 AUTO SSH KEY FIX
if [[ ! -f ~/.ssh/id_rsa.pub ]]; then
  echo "🔐 Generating SSH key..."
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N "" >/dev/null
fi
