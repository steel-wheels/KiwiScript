/**
 * @file	KEManifest.swift
 *  @brief	Define KEManifest class
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
import Foundation

public extension KEResource {
    func loadManifest() -> NSError? {
        let manifest = KEManifestLoader()
        return manifest.load(into: self)
    }
}

private class KEManifestLoader
{
	public init() {

	}

	public func load(into resource: KEResource) -> NSError? {
		switch readNativeValue(from: resource.packageDirectory) {
		case .success(let nvalue):
			if let dict = nvalue.toDictionary() {
				return decode(resource: resource, properties: dict)
			} else {
				return NSError.parseError(message: "Not manifest data")
			}
		case .failure(let err):
			return err
		}
	}

	private func readNativeValue(from url: URL) -> Result<CNValue, NSError> {
		let fileurl = url.appendingPathComponent("manifest.json")
		if let content = fileurl.loadContents() {
			let parser = CNValueParser()
			switch parser.parse(source: content as String) {
			case .success(let value):
				return .success(value)
			case .failure(let err):
				return .failure(err)
			}
		} else {
			return .failure(NSError.parseError(message: "Failed to load manifest file"))
		}
	}

	private struct TableInfo {
		public var identifier:		String
		public var typePath:		String
		public var dataPath:		String

		public init(identifier ident: String, typePath tpstr: String, dataPath dpstr: String) {
			self.identifier = ident
			self.typePath   = tpstr
			self.dataPath   = dpstr
		}
	}

	private func decode(resource res: KEResource, properties data: Dictionary<String, CNValue>) -> NSError? {
		/* Decode: "application" */
		if let appval = data[KEResource.ApplicationCategory] {
			if let apppath = appval.toString() {
                if let err = res.setApplication(path: apppath) {
                    return err
                }
			} else {
				return NSError.parseError(message: "application section must have script file name")
			}
		}
		/* Decode: "libraries" */
		if let libval = data[KEResource.LibrariesCategory] {
			if let libarr = libval.toArray() {
				switch decodeFileArray(arrayValue: libarr) {
				case .success(let patharr):
					for path in patharr {
						res.addLibrary(path: path)
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "libraries section must have library file name properties")
			}
		}
		/* Decode: "threads" */
		if let scrsval = data[KEResource.ThreadsCategory] {
			if let scrsdict = scrsval.toDictionary() {
				switch decodeFileMap(properties: scrsdict) {
				case .success(let fmap):
					for (ident, path) in fmap {
                        if let err = res.setThread(identifier: ident, path: path) {
                            return err
                        }
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "threads section must have thread script file name properties")
			}
		}
		/* Decode: "views" */
		if let viewsval = data[KEResource.ViewsCategory] {
			if let viewsdict = viewsval.toDictionary() {
				switch decodeFileMap(properties: viewsdict) {
				case .success(let fmap):
					for (ident, path) in fmap {
                        if let err = res.setView(identifier: ident, path: path) {
                            return err
                        }
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "views section must have view script file name properties")
			}
		}
		/* Decode: "definitions" */
		if let defval = data[KEResource.DefinitionsCategory] {
			if let defarr = defval.toArray() {
				switch decodeFileArray(arrayValue: defarr) {
				case .success(let patharr):
					for path in patharr {
						res.addDefinition(path: path)
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "definitions section must have array of file names")
			}
		}
		/* Decode: "properties" */
		if let propval = data[KEResource.PropertiesCategory] {
			if let props = propval.toDictionary() {
				switch decodeTables(tableValues: props) {
				case .success(let pinfos):
					for pinfo in pinfos {
                        if let err = res.setProperies(identifier: pinfo.identifier, typePath: pinfo.typePath, valuePath: pinfo.dataPath) {
                            return err
                        }
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "properties section must have script data name")
			}
		}
		/* Decode: "tables" */
		if let tableval = data[KEResource.TablesCategory] {
			if let tables = tableval.toDictionary() {
				switch decodeTables(tableValues: tables) {
				case .success(let tinfos):
					for tinfo in tinfos {
                        if let err = res.setTable(identifier: tinfo.identifier, typePath: tinfo.typePath, valuePath: tinfo.dataPath) {
                                return err
                        }
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "table section must have dictionary of table definitions")
			}
		}
		/* Decode: "images" */
		if let imgval = data[KEResource.ImagesCategory] {
			if let imgdict = imgval.toDictionary() {
				switch decodeFileMap(properties: imgdict) {
				case .success(let imap):
					for (ident, path) in imap {
                        if let err = res.setImage(identifier: ident, path: path) {
                            return err
                        }
					}
				case .failure(let err):
					return err
				}
			} else {
				return NSError.parseError(message: "images section must have image file name properties")
			}
		}
		return nil // no error
	}

	private func decodeFileMap(properties data: Dictionary<String, CNValue>) -> Result<Dictionary<String, String>, NSError> {
		var result: Dictionary<String, String> = [:]
		for key in data.keys {
			if let val = data[key] {
				if let str = val.toString() {
					result[key] = str
				} else {
					return .failure(NSError.parseError(message: "Invalid value for \"\(key)\" in manifest file"))
				}
			} else {
				return .failure(NSError.parseError(message: "Can not happen"))
			}
		}
		return .success(result)
	}

	private func decodeFileArray(arrayValue data: Array<CNValue>) -> Result<Array<String>, NSError> {
		var result: Array<String> = []
		for elm in data {
			if let path = elm.toString() {
				result.append(path)
			} else {
				return .failure(NSError.parseError(message: "Library file path string is required"))
			}
		}
		return .success(result)
	}

	private func decodeTables(tableValues tables: Dictionary<String, CNValue>) -> Result<Array<TableInfo>, NSError> {
		var result: Array<TableInfo> = []
		for (tablename, tableval) in tables {
			let typepath: String
			switch pathInValue(pathName: "type", value: tableval) {
			case .success(let str):
				typepath = str
			case .failure(let err):
				return .failure(err)
			}

			let datapath: String
			switch pathInValue(pathName: "data", value: tableval) {
			case .success(let str):
				datapath = str
			case .failure(let err):
				return .failure(err)
			}
			result.append(TableInfo(identifier: tablename, typePath: typepath, dataPath: datapath))
		}
		return .success(result)
	}

	private func pathInValue(pathName pname: String, value val: CNValue) -> Result<String, NSError> {
		guard let srcdict = val.toDictionary() else {
			let err = NSError.parseError(message: "The value must have dictionary")
			return .failure(err)
		}
		if let pval = srcdict[pname] {
			if let pstr = pval.toString() {
				return .success(pstr)
			} else {
				let err = NSError.parseError(message: "The \(pname) type property must have string")
				return .failure(err)
			}
		} else {
			let err = NSError.parseError(message: "No \(pname) property in table")
			return .failure(err)
		}
	}
}


