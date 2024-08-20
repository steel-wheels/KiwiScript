/**
 * @file	KEResource.swift
 * @brief	Define KEResource class
 * @par Copyright
 *   Copyright (C) 2019 Steel Wheels Project
 */

import CoconutData
#if os(OSX)
import AppKit
#else
import UIKit
#endif

open class KEResource: CNResource
{
    public static let ApplicationCategory       = "application"
    public static let LibrariesCategory         = "libraries"
    public static let ThreadsCategory           = "threads"
    public static let ViewsCategory             = "views"
    public static let DefinitionsCategory       = "definitions"
    public static let PropertiesCategory        = "properties"
    public static let TablesCategory            = "tables"
    public static let ImagesCategory            = "images"

    public static let AnyIdentifier             = "*"

    public override init(packageDirectory dir: URL){
        super.init(packageDirectory: dir)
    }

    public init(singleFileURL url: URL) {
        super.init(packageDirectory: url.deletingLastPathComponent())
        if let err = setApplication(path: url.lastPathComponent) {
            CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
        }
    }

    /*
     * application
     */
    public func setApplication(path pth: String) -> NSError? {
        return super.setURL(category:   KEResource.ApplicationCategory,
                            identifier: KEResource.AnyIdentifier, at: 0, path: pth)
    }

    public func application() -> URL? {
        let urls = super.urlValues(category:   KEResource.ApplicationCategory,
                                   identifier: KEResource.AnyIdentifier)
        return urls.count > 0 ? urls[0] : nil
    }

    /*
     * library
     */
    public func countOfLibraries() -> Int {
        return super.countOfURLs(category: KEResource.LibrariesCategory,
                                 identifier: KEResource.AnyIdentifier)
    }

    public func addLibrary(path pth: String) {
        super.addURL(category:   KEResource.LibrariesCategory,
                     identifier: KEResource.AnyIdentifier, path: pth)
    }

    public func libraries() -> Array<URL> {
        return super.urlValues(category:   KEResource.LibrariesCategory,
                               identifier: KEResource.AnyIdentifier)
    }

    /*
     * thread
     */
    public func setThread(identifier ident: String, path pth: String) -> NSError? {
        return super.setURL(category: KEResource.ThreadsCategory, identifier: ident, at: 0, path: pth)
    }

    public func thread(identifier ident: String) -> URL? {
        let ths = super.urlValues(category: KEResource.ThreadsCategory, identifier: ident)
        return ths.count > 0 ? ths[0] : nil
    }

    /*
     * view
     */
    public func setView(identifier ident: String, path pth: String) -> NSError? {
        return super.setURL(category: KEResource.ViewsCategory, identifier: ident, at: 0, path: pth)
    }

    public func view(identifier ident: String) -> URL? {
        let views = super.urlValues(category: KEResource.ViewsCategory, identifier: ident)
        return views.count > 0 ? views[0] : nil
    }

    /*
     * Definitions
     */
    public func addDefinition(path pth: String) {
        let url = super.packageDirectory.appending(path: pth)
        switch loadValueTypes(from: url) {
        case .success(let vtypes):
            for vtype in vtypes {
                super.addType(category: KEResource.DefinitionsCategory, identifier: KEResource.AnyIdentifier, path: pth, type: vtype)
            }
        case .failure(let err):
            CNLog(logLevel: .error, message: err.toString(), atFunction: #function, inFile: #file)
        }
    }

    public func definitions() -> Array<CNValueType> {
        return super.typeValues(category: KEResource.DefinitionsCategory, identifier: KEResource.AnyIdentifier)
    }

    public func typePaths() -> Array<String> {
        return super.typePaths(category: KEResource.DefinitionsCategory, identifier: KEResource.AnyIdentifier)
    }

    private func loadValueTypes(from url: URL) -> Result<Array<CNValueType>, NSError> {
        guard let txt = url.loadContents() as? String else {
            return .failure(NSError.fileError(message: "Failed to read file: \(url.path)"))
        }
        let parser = CNValueTypeParser()
        switch parser.parse(source: txt) {
        case .success(let vtypes):
            return .success(vtypes)
        case .failure(let err):
            return .failure(err)
        }
    }

    /*
     * Properties
     */
    public func setProperies(identifier ident: String, typePath tpath: String, valuePath vpath: String) -> NSError? {
        return super.setProperties(category: KEResource.PropertiesCategory, identifier: ident, typePath: tpath, dataPath: vpath)
    }

    public func properties(identifier ident: String) -> CNValueProperties? {
        return super.propertiesValue(category: KEResource.PropertiesCategory, identifier: ident)
    }

    /*
     * Tables
     */
    public func setTable(identifier ident: String, typePath tpath: String, valuePath vpath: String) -> NSError? {
        return super.setTable(category: KEResource.TablesCategory, identifier: ident, typePath: tpath, dataPath: vpath)
    }

    public func table(identifier ident: String) -> CNValueTable? {
        return super.tableValue(category: KEResource.TablesCategory, identifier: ident)
    }

    /*
     * images
     */
    public func setImage(identifier ident: String, path pth: String) -> NSError? {
        return super.setImage(category: KEResource.ImagesCategory, identifier: ident, at: 0, path: pth)
    }

    public func image(identifier ident: String) -> CNImage? {
        let imgs = super.imageValues(category: KEResource.ImagesCategory, identifier: ident)
        return imgs.count > 0 ? imgs[0] : nil
    }

    public func imageURL(identifier ident: String) -> URL? {
        let urls = super.imageURLs(category: KEResource.ImagesCategory, identifier: ident)
        return urls.count > 0 ? urls[0] : nil
    }
}

