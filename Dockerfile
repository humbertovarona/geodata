FROM ubuntu:noble

RUN apt-get update && apt-get install -y --no-install-recommends \
    mc \
    nano \
    netcdf-bin \
    nco \
    cdo \
    hdf5-tools \
    udunits-bin \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN useradd -m sciuser

RUN mkdir -p /home/sciuser/OUTPUT

RUN chown -R sciuser:sciuser /home/sciuser/OUTPUT

WORKDIR /home/sciuser/

VOLUME /home/sciuser/OUTPUT

CMD ["bash"]

USER sciuser
