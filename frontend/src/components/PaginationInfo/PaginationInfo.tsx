import React from 'react';
import './PaginationInfo.css';

interface PaginationInfoProps {
  startItem: number;
  endItem: number;
  totalItems: number;
  itemName: string; // ex: "emitentes", "veículos", "condutores"
}

const PaginationInfo: React.FC<PaginationInfoProps> = ({
  startItem,
  endItem,
  totalItems,
  itemName
}) => {
  if (totalItems === 0) {
    return (
      <div className="pagination-info">
        <span>Nenhum {itemName} encontrado</span>
      </div>
    );
  }

  return (
    <div className="pagination-info">
      <span>
        Mostrando {startItem} até {endItem} de {totalItems} {itemName}
      </span>
    </div>
  );
};

export default PaginationInfo;