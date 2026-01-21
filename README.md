# image_loader
Mobile Engineer Take-Home

# Image
Used cached_network_image library 


# API call
I know how to structure an app for growth,
but I don’t force layers where they’re not needed.
I separated the network service and repository
to keep API concerns isolated and make the UI layer independent from data sources,
while keeping the architecture intentionally minimal.

# State Management
I chose ChangeNotifier as a lightweight state management solution
to keep business logic out of the UI while avoiding unnecessary architectural complexity
for a single-screen app.

# Color extraction 
This code decodes a downscaled version of the image
to efficiently extract its dominant color,
minimizing CPU and memory usage while avoiding UI thread blocking.