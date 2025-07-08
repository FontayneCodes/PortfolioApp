# Use the official .NET 9 SDK image
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /app

# Copy project files
COPY *.csproj ./
RUN dotnet restore

# Copy the rest and build
COPY . ./
RUN dotnet publish -c Release -o out

# Use the ASP.NET runtime image for runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=build /app/out .

# Start the app
ENTRYPOINT ["dotnet", "PortfolioApp.dll"]
