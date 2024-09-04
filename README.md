
# Ubuntu with Scientific Tools

This Dockerfile sets up an Ubuntu-based environment with various scientific tools installed, including `mc`, `nano`, `netcdf-bin`, `nco`, `cdo`, and `hdf5-tools`. It also creates a specific user (`sciuser`) and prepares a working directory with volume support for output management.

## Version

1.0

## Release date

2024-08-30

## Dockerfile Overview

The Dockerfile uses the `ubuntu:noble` base image and installs a range of useful tools for scientific data manipulation and visualization. 

### Installed Packages:
- `mc`: Midnight Commander (file manager).
- `nano`: Simple text editor.
- `netcdf-bin`: Tools for reading and writing NetCDF files.
- `nco`: NetCDF Operators (tools for manipulating NetCDF files).
- `cdo`: Climate Data Operators.
- `hdf5-tools`: Tools for working with HDF5 files.
- `udunits-bin`: Unit conversion tools.

### Directory Structure
- `/home/sciuser/WORKDIR`: The working directory for the user `sciuser` inside the container.
- `/home/sciuser/OUTPUT`: The output directory inside the container.

### User Setup:
A user `sciuser` is created within the container, and ownership of the `/home/sciuser/WORKDIR` directory is given to this user. The user is set to operate within this directory when the container starts.

## Instructions

### 1. Building the Docker Image

To build the Docker image from the provided `Dockerfile`, navigate to the directory containing the Dockerfile and run:

```bash
docker build -t geodata .
```

This will create an image named `geodata`.


## How to install

```bash
docker pull humbertovarona/geodata:v1
```

or 

```bash
docker pull humbertovarona/geodata:latest
```


### 2. Running the Docker Container

To run the container with a mounted volume from your local machine, execute the following command from your local terminal:

#### Example 1:

```bash
docker run -it -v $(pwd)/:/home/sciuser/ -v $(pwd)/OUTPUT:/home/sciuser/OUTPUT geodata cdo sinfo /home/sciuser/sst.oisst.mon.ltm.1991-2020.nc
```

#### Example 2:

```bash
docker run -it -v $(pwd)/:/home/sciuser/ -v $(pwd)/OUTPUT:/home/sciuser/OUTPUT geodata cdo ymonmean /home/sciuser/sst.oisst.mon.ltm.1991-2020.nc /home/sciuser/OUTPUT/mmClim.nc
```

#### Example 3:

```bash
docker run -it -v $(pwd)/:/home/sciuser/ -v $(pwd)/OUTPUT:/home/sciuser/OUTPUT geodata ncdump -h /home/sciuser/sst.oisst.mon.ltm.1991-2020.nc
```

Replace `/path/to/local/output` with the path to the directory on your local machine where you want the container to store output files.

This command:
- Runs the container in interactive mode (`-it`).
- Mounts a local directory (`/path/to/local/output`) to the container's `/home/sciuser/OUTPUT` directory using the `-v` flag.
  
The container starts with the default command `bash`, placing you in an interactive shell as the user `sciuser`.

### 3. Accessing Installed Tools

Once inside the container's shell, the following tools are available for use:

- `nco` (NetCDF Operators): Manipulate and analyze NetCDF files. Example usage:

```bash
ncks -h input_file.nc
```

- `cdo` (Climate Data Operators): Process climate and meteorological data. Example usage:

```bash
cdo info input_file.nc
```

- `h5dump`: View the contents of HDF5 files. Example usage:

```bash
h5dump file.h5
```

### 4. Exiting the Container

To exit the container's interactive shell, simply type `exit` and press `Enter`.

### 5. Removing the Container

To remove the container after use, first find the container ID or name:

```bash
docker ps -a
```

Then remove it with:

```bash
docker rm <container_id>
```

## Directory and Volume Explanation

- **WORKDIR**: `/home/sciuser/WORKDIR` is the main working directory where the user `sciuser` operates.
- **OUTPUT Volume**: The `/home/sciuser/OUTPUT` directory is a volume. By using the `-v` flag when running the container, you can map this directory to a local folder on the host machine, allowing for the output to be stored and accessed on the host.

This setup ensures that data and results generated inside the container can be easily accessed from the host machine.

## Conclusion

This Docker container is designed for scientific data manipulation, providing a pre-installed set of tools and a structured working environment. The setup includes a dedicated user and volume for output management, facilitating easy interaction between the container and the host machine.

## Contribution

If you wish to contribute to this project, please open an issue or submit a pull request on [GitHub](https://github.com/humbertovarona/geodata/). Contributions to enhance the functionality or fix issues are always welcome.

## License

This project is licensed under the MIT License. Feel free to use and modify the code as per the terms of the license.

---
