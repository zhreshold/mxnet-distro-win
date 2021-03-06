# pylint: disable=invalid-name, exec-used
"""Setup mxnet package."""
from __future__ import absolute_import
from datetime import datetime
import os
import sys
import shutil
import platform

if platform.system() == 'Linux':
    sys.argv.append('--universal')
    sys.argv.append('--plat-name=manylinux1_x86_64')
elif platform.system() == 'Windows':
    sys.argv.append('--universal')
    target_arch = os.environ['TARGET_ARCH']
    if target_arch == '32':
        sys.argv.append('--plat-name=win32')
    elif target_arch == '64':
        sys.argv.append('--plat-name=win_amd64')
    else:
        raise ValueError("Invalid target_arch: " + str(target_arch))

from setuptools import setup, find_packages
from setuptools.dist import Distribution

# We can not import `mxnet.info.py` in setup.py directly since mxnet/__init__.py
# Will be invoked which introduces dependences
CURRENT_DIR = os.path.dirname(__file__)
libinfo_py = os.path.join(CURRENT_DIR, 'mxnet-build/python/mxnet/libinfo.py')
libinfo = {'__file__': libinfo_py}
exec(compile(open(libinfo_py, "rb").read(), libinfo_py, 'exec'), libinfo, libinfo)

LIB_PATH = libinfo['find_lib_path']()
__version__ = libinfo['__version__']
if 'TRAVIS_TAG' in os.environ and os.environ['TRAVIS_TAG'].startswith('patch-'):
    __version__ = os.environ['TRAVIS_TAG'].split('-')[1]
elif 'APPVEYOR_REPO_TAG_NAME' in os.environ and os.environ['APPVEYOR_REPO_TAG_NAME'].startswith('patch-'):
    __version__ = os.environ['APPVEYOR_REPO_TAG_NAME'].split('-')[1]
elif 'TRAVIS_TAG' in os.environ or 'APPVEYOR_REPO_TAG_NAME' in os.environ:
    pass
else:
    __version__ += 'b{0}'.format(datetime.today().strftime('%Y%m%d'))

class BinaryDistribution(Distribution):
    def has_ext_modules(self):
        return platform.system() == 'Darwin'


DEPENDENCIES = [
    'numpy',
    'requests',
    'graphviz',
]

shutil.rmtree(os.path.join(CURRENT_DIR, 'mxnet'), ignore_errors=True)
shutil.copytree(os.path.join(CURRENT_DIR, 'mxnet-build/python/mxnet'),
                os.path.join(CURRENT_DIR, 'mxnet'))
shutil.copy(LIB_PATH[0], os.path.join(CURRENT_DIR, 'mxnet'))

# copy tools to mxnet package
shutil.rmtree(os.path.join(CURRENT_DIR, 'mxnet/tools'), ignore_errors=True)
os.mkdir(os.path.join(CURRENT_DIR, 'mxnet/tools'))
shutil.copy(os.path.join(CURRENT_DIR, 'mxnet-build/tools/launch.py'), os.path.join(CURRENT_DIR, 'mxnet/tools'))
shutil.copy(os.path.join(CURRENT_DIR, 'mxnet-build/tools/im2rec.py'), os.path.join(CURRENT_DIR, 'mxnet/tools'))
shutil.copy(os.path.join(CURRENT_DIR, 'mxnet-build/tools/kill-mxnet.py'), os.path.join(CURRENT_DIR, 'mxnet/tools'))
shutil.copy(os.path.join(CURRENT_DIR, 'mxnet-build/tools/parse_log.py'), os.path.join(CURRENT_DIR, 'mxnet/tools'))
shutil.copytree(os.path.join(CURRENT_DIR, 'mxnet-build/tools/caffe_converter'), os.path.join(CURRENT_DIR, 'mxnet/tools/caffe_converter'))
shutil.copytree(os.path.join(CURRENT_DIR, 'mxnet-build/tools/bandwidth'), os.path.join(CURRENT_DIR, 'mxnet/tools/bandwidth'))

package_name = 'mxnet'

variant = os.environ['mxnet_variant'].upper()
if variant != 'CPU':
    package_name = 'mxnet_{0}'.format(variant.lower())

with open('PYPI_README.md') as readme_file:
    long_description = readme_file.read()

with open('{0}_ADDITIONAL.md'.format(variant)) as variant_doc:
    long_description = long_description + variant_doc.read()

# pypi only supports rst, so use pandoc to convert
import pypandoc
long_description = pypandoc.convert_text(long_description, 'rst', 'md')
short_description = 'MXNet is an ultra-scalable deep learning framework.'
libraries = []
if variant == 'CPU':
    libraries.append('openblas')
else:
    if variant.startswith('CU80'):
        libraries.append('CUDA-8.0')
    elif variant.startswith('CU75'):
        libraries.append('CUDA-7.5')
    if variant.endswith('MKL'):
        libraries.append('MKL-ML')

short_description += ' This version uses {0}.'.format(' and '.join(libraries))

package_data = {'mxnet': [os.path.join('mxnet', os.path.basename(LIB_PATH[0]))]}
# this is a hack to mingw openblas because its performance is better than vs
if platform.system() == 'Windows':
    import glob
    dll_dir = os.path.join(os.environ['OpenBLAS_HOME'], 'bin')
    openblas_dlls = glob.glob(os.path.abspath(os.path.join(dll_dir, '*.dll')))
    for dll in openblas_dlls:
        shutil.copy(dll, os.path.join(CURRENT_DIR, 'mxnet'))
        package_data['mxnet'].append('mxnet/' + os.path.basename(dll))
if variant.endswith('MKL'):
# uncomment below lines when we start using mkldnn
    # shutil.copy('../deps/lib/libmkldnn.so', os.path.join(CURRENT_DIR, 'mxnet'))
    # shutil.copy('../deps/share/doc/mkldnn/LICENSE', os.path.join(CURRENT_DIR, 'mxnet/MKLDNN_LICENSE'))
    # package_data['mxnet'].append('mxnet/MKLDNN_LICENSE')
    # package_data['mxnet'].append('mxnet/libmkldnn.so')
    if platform.system() == 'Darwin':
        shutil.copy(os.path.join(os.path.dirname(LIB_PATH[0]), 'libmklml.dylib'), os.path.join(CURRENT_DIR, 'mxnet'))
        shutil.copy(os.path.join(os.path.dirname(LIB_PATH[0]), 'libiomp5.dylib'), os.path.join(CURRENT_DIR, 'mxnet'))
        package_data['mxnet'].append('mxnet/libmklml.dylib')
        package_data['mxnet'].append('mxnet/libiomp5.dylib')
    elif platform.system() == 'Linux':
        shutil.copy(os.path.join(os.path.dirname(LIB_PATH[0]), 'libmklml_intel.so'), os.path.join(CURRENT_DIR, 'mxnet'))
        shutil.copy(os.path.join(os.path.dirname(LIB_PATH[0]), 'libiomp5.so'), os.path.join(CURRENT_DIR, 'mxnet'))
        package_data['mxnet'].append('mxnet/libmklml_intel.so')
        package_data['mxnet'].append('mxnet/libiomp5.so')
    elif platform.system() == 'Windows':
        raise NotImplementedError("Not ready for mkl windows")
    else:
        raise RuntimeError('Unsupported system: {}'.format(platform.system()))
    shutil.copy(os.path.join(os.path.dirname(LIB_PATH[0]), '../MKLML_LICENSE'), os.path.join(CURRENT_DIR, 'mxnet'))
    package_data['mxnet'].append('mxnet/MKLML_LICENSE')

from mxnet.base import _generate_op_module_signature
from mxnet.ndarray.register import _generate_ndarray_function_code
from mxnet.symbol.register import _generate_symbol_function_code
_generate_op_module_signature('mxnet', 'symbol', _generate_symbol_function_code)
_generate_op_module_signature('mxnet', 'ndarray', _generate_ndarray_function_code)

print('package_data', package_data)
setup(name=package_name,
      version=__version__,
      long_description=long_description,
      description=short_description,
      zip_safe=False,
      packages=find_packages(),
      package_data=package_data,
      include_package_data=True,
      install_requires=DEPENDENCIES,
      distclass=BinaryDistribution,
      license='Apache 2.0',
      url='https://github.com/dmlc/mxnet')
