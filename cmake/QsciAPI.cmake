# Concatenation/editing of QScintilla API files for PyQGIS
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Copyright (c) 2012, Larry Shaffer <larrys@dakotacarto.com>
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

SET(QGIS_PYTHON_API_FILE "${CMAKE_BINARY_DIR}/python/qsci_apis/PyQGIS.api")

IF(EXISTS "${CMAKE_BINARY_DIR}/python/qgis.gui.api")
  FILE(READ "${CMAKE_BINARY_DIR}/python/qgis.gui.api" FILE_CONTENT)
  STRING(REGEX MATCHALL "gui\\.QgisInterface([^\n]+)" MATCHED_CONTENT "${FILE_CONTENT}")
  FOREACH(matchedLine ${MATCHED_CONTENT})
    STRING(REGEX REPLACE "gui\\.QgisInterface(.*)" "qgis.utils.iface\\1\n" MODIFIED_MATCH "${matchedLine}")
    FILE(APPEND "${QGIS_PYTHON_API_FILE}" "${MODIFIED_MATCH}")
  ENDFOREACH(matchedLine)
ENDIF(EXISTS "${CMAKE_BINARY_DIR}/python/qgis.gui.api")

FOREACH(apiFile qgis.core.api qgis.gui.api qgis.analysis.api qgis.networkanalysis.api)
  SET(api "${CMAKE_BINARY_DIR}/python/${apiFile}")
  IF(EXISTS "${api}")
    FILE(READ "${api}" FILE_CONTENT)
    STRING(REGEX REPLACE "([^\n]+)" "qgis.\\1" MODIFIED_CONTENT "${FILE_CONTENT}")
    FILE(APPEND "${QGIS_PYTHON_API_FILE}" "${MODIFIED_CONTENT}")
  ENDIF(EXISTS "${api}")
ENDFOREACH(apiFile)
