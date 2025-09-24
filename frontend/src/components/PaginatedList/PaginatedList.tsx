import React from 'react';
import Pagination from '../Pagination/Pagination';
import PaginationInfo from '../PaginationInfo/PaginationInfo';
import './PaginatedList.css';

interface PaginationData {
  totalItems: number;
  totalPages: number;
  currentPage: number;
  pageSize: number;
  hasNextPage: boolean;
  hasPreviousPage: boolean;
  startItem: number;
  endItem: number;
}

interface PaginatedListProps {
  pagination: PaginationData;
  onPageChange: (page: number) => void;
  itemName: string;
  children: React.ReactNode;
}

const PaginatedList: React.FC<PaginatedListProps> = ({
  pagination,
  onPageChange,
  itemName,
  children
}) => {
  return (
    <div className="paginated-list">
      <div className="list-content">
        {children}
      </div>

      <div className="pagination-controls">
        <PaginationInfo
          startItem={pagination.startItem}
          endItem={pagination.endItem}
          totalItems={pagination.totalItems}
          itemName={itemName}
        />

        <Pagination
          currentPage={pagination.currentPage}
          totalPages={pagination.totalPages}
          onPageChange={onPageChange}
          hasNextPage={pagination.hasNextPage}
          hasPreviousPage={pagination.hasPreviousPage}
        />
      </div>
    </div>
  );
};

export default PaginatedList;