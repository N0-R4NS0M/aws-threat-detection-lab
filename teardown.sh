#!/bin/bash

echo "⚠️  This will destroy all AWS resources created by this lab."
read -p "Are you sure you want to continue? (y/n): " confirm

if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
  echo "🔄 Destroying resources..."
  cd terraform
  terraform destroy
else
  echo "❌ Teardown canceled."
fi
