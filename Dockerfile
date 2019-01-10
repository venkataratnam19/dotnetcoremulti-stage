# First Stage
FROM microsoft/dotnet:1.1.1-sdk

RUN mkdir /build
WORKDIR /build

COPY dotnetapp.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish -c Release -o out


# Second Stage
FROM microsoft/dotnet:1.1.1-runtime
WORKDIR /app
CMD ["dotnet", "dotnetapp.dll"]

COPY --from=0 /build/out /app/

