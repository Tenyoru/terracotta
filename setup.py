import os
import urllib.request
import time

directory_name = "maps"
osm_url = "https://download.bbbike.org/osm/bbbike/Poznan/Poznan.osm.pbf"
osm_file_name = "sample.osm.pbf"


def reporthook(block_num, block_size, total_size):
    downloaded = block_num * block_size
    percent = downloaded / total_size * 100 if total_size > 0 else 0
    print(f"\rProgress: {percent:6.2f}%", end="")


def download():
    file_path = os.path.join(directory_name, osm_file_name)
    print(f"Downloading {osm_url} → {file_path}")

    start_time = time.time()
    urllib.request.urlretrieve(osm_url, file_path, reporthook)
    elapsed = time.time() - start_time

    print(f"\nDownload complete in {elapsed:.2f} seconds!")


def main():
    if not os.path.isdir(directory_name):
        os.mkdir(directory_name)
        print(f"Created directory: {directory_name}")

    file_path = os.path.join(directory_name, osm_file_name)
    if not os.path.isfile(file_path):
        download()
    else:
        print(f"File already exists: {file_path}")


if __name__ == "__main__":
    main()
