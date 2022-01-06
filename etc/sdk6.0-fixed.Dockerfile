FROM arm32v7/debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    ca-certificates \
    \
    # .NET Core dependencies
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    libssl1.1 \
    libstdc++6 \
    zlib1g \
    wget \
    && rm -rf /var/lib/apt/lists/*

ENV \
    # Configure web servers to bind to port 80 when present
    ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true \
    # Set the invariant mode since icu-libs isn't included (see https://github.com/dotnet/announcements/issues/20)
    DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=true \
    # ASP.NET Core version
    ASPNET_VERSION=6.0.101 \
    # Set the default console formatter to JSON
    Logging__Console__FormatterName=Json

ENV DOTNET_VERSION=6.0.101

RUN wget -O dotnet.tar.gz https://dotnetcli.azureedge.net/dotnet/Sdk/$DOTNET_VERSION/dotnet-sdk-$DOTNET_VERSION-linux-arm.tar.gz \
    # && dotnet_sha512='575037f2e164deaf3bcdd82f7b3f2b5a5784547c5bad4070375c00373722265401b88a81695b919f92ca176f21c1bdf1716f8fce16ab3d301ae666daa8cae750' \
    # && echo "$dotnet_sha512  dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -C /usr/share/dotnet -oxzf dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \
    && rm dotnet.tar.gz
