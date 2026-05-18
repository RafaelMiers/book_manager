# Build stage
FROM cirrusci/flutter:stable AS build
WORKDIR /app

# Copy pubspec and get dependencies first to leverage layer cache
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the project and build web release
COPY . .
RUN flutter build web --release

# Serve with nginx
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
