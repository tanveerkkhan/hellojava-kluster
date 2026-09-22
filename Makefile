CHART_PATH=helm/demo-app
RELEASE_NAME=demo-app

.PHONY: deploy-local deploy-eks destroy-local destroy-eks lint

lint:
	helm lint $(CHART_PATH) -f $(CHART_PATH)/values.yaml -f $(CHART_PATH)/values-local.yaml

deploy-local:
	helm upgrade --install $(RELEASE_NAME) $(CHART_PATH) \
		-f $(CHART_PATH)/values.yaml \
		-f $(CHART_PATH)/values-local.yaml \
		--wait --timeout 2m

deploy-eks:
	helm upgrade --install $(RELEASE_NAME) $(CHART_PATH) \
		-f $(CHART_PATH)/values.yaml \
		-f $(CHART_PATH)/values-eks.yaml \
		--set image.repository=$(ECR_REPO_URL) \
		--set image.tag=$(IMAGE_TAG) \
		--wait --timeout 5m

destroy-local:
	helm uninstall $(RELEASE_NAME) || true

destroy-eks:
	helm uninstall $(RELEASE_NAME) || true
