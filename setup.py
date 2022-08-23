from setuptools import setup

setup(
    name="prizmdatawrangling",
    version='1.0',
    author='Fernando Zago',
    packages=['prizmdatawrangling'],
    package_data={'prizmdatawrangling': ['settings.json']},

    python_requires='>=3.6',
    install_requires=[
        "numpy >= 1.2",
        "scipy >= 1.7",
        "healpy >= 1.0",
        "pygdsm >= 1.2",
        "pbio >= 0.0.2"
    ],
)