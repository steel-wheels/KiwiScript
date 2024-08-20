interface CollectionDataIF {
  count : number ;
  item(p0 : number): string | null ;
  addItem(p0 : IconIF): void ;
  addItems(p0 : IconIF[]): void ;
}
