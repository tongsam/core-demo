FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.csproj .
RUN dotnet restore

# copy and publish app and libraries
COPY . .
RUN dotnet publish -c release -o /app 

# final stage/image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1



ENV ASPNETCORE_URLS=http://*:80
ENV ASPNETCORE_ENVIRONMENT=”production”

EXPOSE 80

WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["dotnet", "Core-Demo.dll"]
